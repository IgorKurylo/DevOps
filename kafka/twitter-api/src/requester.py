import requests


class Requester:
    def __init__(self, bearer_token, params, base_url):
        self.__bearer_token = bearer_token
        self.__params = params
        self.__base_url = base_url

    def __headers(self):
        return {"Authorization": "Bearer {}".format(self.__bearer_token)}

    def send_request(self):
        response = requests.request("GET", self.__base_url, headers=self.__headers(), params=self.__params)
        print("Endpoint Response Code: " + str(response.status_code))
        if response.status_code != 200:
            raise Exception(response.status_code, response.text)
        return response.json()
