# FriendShare

## Description

I used the following pod for the following reasons:

- SnapKit: For easy constraints
- Quick and Nimble: For pretty testing!
- CryptoSwift: To encrypt user and place data when sending over SMS
- DeepLinkKit: For easier deep link routing
- RealmSwift: For local data storage
- FacebookCore, FacebookLogin: As I needed a uniform way to manage IDs and get names
- GooglePlaces, GooglePlacePicker, GoogleMaps: Because you told me to

Most everything is laid out in the Main storyboard. Once you get up and running you can test the links by sending one to yourself or by using the following example:

[FriendShare://hello?place=6fcc9f442b5d499d245ce65d3a6760633a42b6618d6bbf22c61a69d22914aa92d628c5fe73bf8e5c25573d83ddd33c0c82923d8d3dac70bda2c19f718e357f897206e267b9978db16428451376b280bb870304c5bc8e0e22333821ec4f7441beeb71cd0637eb805b777fb3bc62e2d2d73e281e1481f420c2d5eb678abb34263a20e1e2d92838acd8ec5316409e5f3e1c&user=0710ee73f7f79bd4edebe91c78f797f6e6f230d6aeef1bf5316e008ef23244c100ace4b886a92edc634ffede796fb4cb2905577ad32269c1bf3099763c5ede9b9583ad66301ee1a41a8d43d1ae65c049](FriendShare://hello?place=6fcc9f442b5d499d245ce65d3a6760633a42b6618d6bbf22c61a69d22914aa92d628c5fe73bf8e5c25573d83ddd33c0c82923d8d3dac70bda2c19f718e357f897206e267b9978db16428451376b280bb870304c5bc8e0e22333821ec4f7441beeb71cd0637eb805b777fb3bc62e2d2d73e281e1481f420c2d5eb678abb34263a20e1e2d92838acd8ec5316409e5f3e1c&user=0710ee73f7f79bd4edebe91c78f797f6e6f230d6aeef1bf5316e008ef23244c100ace4b886a92edc634ffede796fb4cb2905577ad32269c1bf3099763c5ede9b9583ad66301ee1a41a8d43d1ae65c049)

Something is strange with deep links so the app needs to be in the background when you click it for it to register. I didn't have enough time to figure out why.


