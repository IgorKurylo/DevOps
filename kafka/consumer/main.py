from kafka_consumer import Consumer
import logging
import os


def main():
    servers = os.environ.get('BROKERS')
    logging.info(f"Brokers: {servers}")
    consumer = Consumer(servers)
    consumer.read_data()


if __name__ == "__main__":
    main()
