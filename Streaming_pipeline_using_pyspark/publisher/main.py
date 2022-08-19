import asyncio
import json
import time
import random
import pycountry
from faker import Faker
from azure.eventhub.aio import EventHubProducerClient
from azure.eventhub import EventData
import country_converter as cc

# Creating a Faker instance and seed
fake = Faker(locale='en_US')
Faker.seed(123579)

TOTAL_MESSAGES = 10
TIME_INTERVAL = 2
TOTAL_BATCHES = 10
status = ['Approved', 'Hold', 'Rejected']
type_id = ['PL', 'PM', 'PT', 'PH', 'CA', 'CH', 'CP']


async def run():
    # Create a producer client to send messages to the event hub.
    # Specify a connection string to your event hubs namespace and
    # the event hub name.
    STOP_STREAMING = False
    b = 0
    producer = EventHubProducerClient.from_connection_string(
        conn_str="Endpoint=sb://events-feed.servicebus.windows.net/;SharedAccessKeyName=manage_user_access_policy;SharedAccessKey=EYMfb85RM5wMgBujKH+D+P/MbFb1Auo+BGkgAbWakII=;EntityPath=demo-topic",
        eventhub_name="demo-topic")
    while not STOP_STREAMING:
        async with producer:
            # Create a batch.
            event_data_batch = await producer.create_batch()

            i = 0
            while i < TOTAL_MESSAGES:
                payload = {
                    'id': fake.uuid4(),
                    'customer_name': fake.name(),
                    'phone_number': fake.unique.phone_number(),
                    'city': fake.city(),
                    'country': cc.findCountryAlpha3(fake.country()),
                    'claim_amount': random.randint(1000, 9999),
                    'type_id': random.choice(type_id),
                    'status': random.choice(status)
                }

                print('Event generated: {}'.format(json.dumps(payload)))
                # Add events to the batch.
                event_data_batch.add(EventData(json.dumps(payload)))
                time.sleep(TIME_INTERVAL)
                i = i + 1

            # Send the batch of events to the event hub.
            await producer.send_batch(event_data_batch)
            b = b + 1
            if b >= TOTAL_BATCHES:
                STOP_STREAMING = True
            else:
                STOP_STREAMING = False
            print('########-----> Sent batch of {} events to broker - Batch Id: {}'.format(TOTAL_MESSAGES, b))


loop = asyncio.get_event_loop()
loop.run_until_complete(run())
