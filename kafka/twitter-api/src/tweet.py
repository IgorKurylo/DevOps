class Tweet:
    def __init__(self, id, user_name, hashtags) -> None:
        self.id = id
        self.user_name = user_name
        self.hashtags = hashtags

    def __str__(self):
        return f"Id: {self.id},\nUserName: {self.user_name},\nHashTags:{self.hashtags}"
