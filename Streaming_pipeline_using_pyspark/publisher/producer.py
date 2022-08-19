from confluent_kafka import Producer
from faker import Faker
import sys
import random
import argparse
import time
import json
import country_converter as cc

# Creating a Faker instance and seed
fake = Faker()
Faker.seed(123579)

status = ['Approved', 'Hold', 'Rejected']
type_id = ['PL', 'PM', 'PT', 'PH', 'CA', 'CH', 'CP']


# function produce_msgs starts producing messages with Faker
def produce_msgs(namespace='example_host',
                 connection='example_connection_string',
                 topic='airplane_message',
                 messages=10,
                 sleeptime=10):
    conf = {
        'bootstrap.servers': namespace + '.servicebus.windows.net:9093',
        'security.protocol': 'SASL_SSL',
        'sasl.mechanism': 'PLAIN',
        'sasl.username': '$ConnectionString',
        'sasl.password': connection,
        'client.id': 'kafka-example-producer'
    }

    producer = Producer(**conf)

    def delivery_callback(err, msg):
        if err:
            sys.stderr.write('%% Message failed delivery: %s\n' % err)
        else:
            sys.stderr.write(
                '%% Message delivered to %s [%d] @ offset %o\n' % (msg.topic(), msg.partition(), msg.offset()))

    if messages <= 0:
        messages = float('inf')
    i = 0

    print('Sending ' + str(messages) + ' messages to the Event Hub')

    while i < messages:
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

        print('Sending: {}'.format(json.dumps(payload)))
        # sending the message to Kafka
        try:
            producer.produce(topic, json.dumps(str(payload)), callback=delivery_callback)
        except BufferError as e:
            sys.stderr.write('%% Local producer queue is full (%d messages awaiting delivery): try again\n' % len(p))
        producer.poll(0)

        randomsleep = random.randint(0, int(sleeptime * 10000)) / 100000
        print('Sleeping for...' + str(randomsleep) + 's')
        time.sleep(randomsleep)

        i = i + 1

    producer.flush()


# Calling the main function configures the connection to Event Hubs and the number of messages to send
def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--namespace', help='Event Hub Namespace', required=True)
    parser.add_argument('--connection', help='Event Hub Connection String', required=True)
    parser.add_argument('--topic', help='Topic Name', required=True)
    parser.add_argument('--messages', help='Number of messages to produce (0 for unlimited)', required=True)
    parser.add_argument('--sleeptime', help='Max time between messages (0 for none)', required=True)
    args = parser.parse_args()
    produce_msgs(namespace=args.namespace,
                 connection=args.connection,
                 topic=args.topic,
                 messages=int(args.messages),
                 sleeptime=float(args.sleeptime)
                 )


if __name__ == '__main__':
    main()
