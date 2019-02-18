# simple-storage
Simple key-value storage based on Tarantool with HTTP API. Key must be unique string.

Web-version is available at https://powerful-thicket-97841.herokuapp.com/

Request examples:
```
POST /kv body : { key : "abc", value : JSON }

PUT /kv/abc body : { value : JSON }

GET /kv/abc

DELETE /kv/abc
```
