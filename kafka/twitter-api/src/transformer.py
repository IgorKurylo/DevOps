from tweet import Tweet


class Transformer:
    def __init__(self, tweets, includes):
        self.tweets = tweets
        self.includes = includes
        self.users = {}

    def extract_data(self):
        tweets = []
        self.__transform_list_to_map()
        for tweet in self.tweets:
            tweet_id = tweet['id']
            hash_tags = []
            user_name = self.users.get(tweet['author_id'])
            if 'entities' in tweet:
                if 'hashtags' in tweet['entities']:
                    [hash_tags.append(hashtag['tag']) for hashtag in tweet['entities']['hashtags']]
            t = Tweet(id=tweet_id, user_name=user_name, hashtags=hash_tags)
            tweets.append(t)
        return tweets

    def __transform_list_to_map(self):
        users = self.includes['users']
        for user in users:
            self.users[user['id']] = user['username']

    def to_json_list(self, tweets_result):
        json_list = []
        for tweet in tweets_result:
            json_list.append({
                "id": tweet.id,
                "userName": tweet.user_name,
                "tags": tweet.hashtags
            })
        return json_list
