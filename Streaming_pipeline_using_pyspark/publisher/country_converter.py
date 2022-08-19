import pycountry


def findCountryAlpha3(country_name):
    try:
        return pycountry.countries.get(name=country_name).alpha_3
    except:
        return "USA"


if __name__ == '__main__':
    print(findCountryAlpha3("Congo"))

