import json
import os
from flask import Flask, jsonify, make_response
from flask import Response

from config import Config
from requester import Requester
from transformer import Transformer
from kafka_producer import Producer
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("Producer")
app = Flask(__name__)

bearer_token = os.environ.get('BEARER_TOKEN')
brokers = os.environ.get('BROKERS')
k_producer = Producer(brokers)
configuration = Config()


def main():
    app.run(host='0.0.0.0', port=8080, debug=True)
    logger.info("BROKERS:", brokers)


def produce_tweets(tweets_result, hashtag):
    if len(tweets_result) > 0:
        logger.info(f"receive {len(tweets_result)} tweets")
    for tweet in tweets_result:
        logger.info(f"Tweet id {tweet.id} sent")
        value = {
            "id": tweet.id,
            "userName": tweet.user_name,
            "tags": tweet.hashtags
        }
        k_producer.write_data(hashtag, key=tweet.id, value=value)


@app.route("/tweeter")
def search_endpoint():
    try:
        response = search_tweets()
        trans = Transformer(response['data'], response['includes'])
        tweets_result = trans.extract_data()
        produce_tweets(tweets_result, configuration.get_twitter_params("hashtag"))
        response_tweets = trans.to_json_list(tweets_result)
        return make_response(jsonify(response_tweets, 200))
    except Exception as e:
        return make_response(f"Error on request {str(e)}", 500)


def search_tweets():
    url = configuration.get_twitter_base_url()
    params = {
        'query': "#{}".format(configuration.get_twitter_params("hashtag")),
        'user.fields': configuration.get_twitter_params("user"),
        'expansions': configuration.get_twitter_params("extra"),
        'tweet.fields': configuration.get_twitter_params("tweet")
    }
    requester = Requester(bearer_token=bearer_token, params=params, base_url=url)
    response = requester.send_request()
    return response


if __name__ == "__main__":
    main()
