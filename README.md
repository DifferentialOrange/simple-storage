# simple-storage
Simple key-value storage based on Tarantool with HTTP API. Key must be unique string.
Web-version is available at https://powerful-thicket-97841.herokuapp.com/

Request examples:
POST route/kv body : { key : "abc", value : JSON }
PUT route/kv/abc body : { value : JSON }
GET route/kv/abc
DELETE route/kv/abc
