# deadlock-on-rack-timeout
The code don't occurs deadlock!!!!!!!!!

```
be puma --config puma_config.rb
```
```
echo "loop  {`curl 'http://localhost:9292'`; sleep 1 }" | irb
```
