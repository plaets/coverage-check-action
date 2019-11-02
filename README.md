## Coverage check

Check your coverage minimum coverage percentage.

### Usage

#### [Simplecov](https://github.com/colszowka/simplecov)

```yml
- uses: devmasx/coverage-check-action@coverage-check
  with:
    result_path: coverage/.last_run.json
    token: ${{secrets.GITHUB_TOKEN}}
    type: simplecov
    min_coverage: 90
```

## Screenshots

![Success](./screenshots/success.png)
![Fail](./screenshots/fail.png)
