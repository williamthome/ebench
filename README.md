# ebench

An app to benchmark erlang libs.

## Benchmarking

The result is average iterations per second.
Higher is best.

### Example

```shell
    $ rebar3 shell
    1> ebench_json:run().
    [10,7,46,14,7]
```
