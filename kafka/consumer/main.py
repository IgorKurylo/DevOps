from kafka_consumer import Consumer
import logging
import os


# entry point, define Consumer and read data
def main():
    servers = os.environ.get('BROKERS')
    logging.info(f"Brokers: {servers}")
    consumer = Consumer(servers.split(","))
    consumer.read_data()


if __name__ == "__main__":
    main()
