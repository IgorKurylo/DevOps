import confuse


class Config:
    def __init__(self) -> None:
        self.config = confuse.Configuration('twitter-api', __name__)
        self.config.set_file('config.yaml')

    def get_twitter_params(self, key):
        return self.config["twitter"]["params"][key].get()

    def get_twitter_base_url(self):
        return self.config["twitter"]["uri"].get()

    def get_global_props(self, key):
        return self.config[key].get()
