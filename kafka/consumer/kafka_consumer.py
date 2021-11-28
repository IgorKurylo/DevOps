from kafka import KafkaConsumer
from json import loads
from time import sleep
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger("Consumer")


class Consumer:
    def __init__(self, servers) -> None:
        logging.basicConfig(level=logging.INFO)
        self.consumer = KafkaConsumer(
            'DevOps',
            bootstrap_servers=[servers],
            auto_offset_reset='earliest',
            enable_auto_commit=True,
            group_id='devops-grp',
            value_deserializer=lambda x: loads(x.decode('utf-8'))
        )
        self.consumer.subscribe(['DevOps'])

    def read_data(self):
        for event in self.consumer:
            event_data = event.value
            logger.info(f"Tweets Data: {event_data}")
            sleep(2)
