
from json import dumps
from time import sleep

from kafka import KafkaProducer

# kafka producer class, define needed configuration for write data
class Producer:
    def __init__(self, servers):
        self.producer = KafkaProducer(
            bootstrap_servers=servers,
            key_serializer=str.encode,
            value_serializer=lambda x: dumps(x).encode('utf-8')
        )

    def write_data(self, topic, key, value):
        self.producer.send(topic,value,key)
        sleep(0.5)
