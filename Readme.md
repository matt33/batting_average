# Batting Averages

Batting average is simple and a common way to measure batter’s performance.

## Input

The application should takes an input in form of a CSV file. The file will be
comma separated CSV with headers. The headers that need to be in the CSV are: “playerID”,
“yearID”, teamID”, “AB”, and “H”.

## Output

The applications ingests a raw CSV file with player statistics and
provides player rankings based on their batting performance.

## Usage

Run all commands in the root of this directory.

Run without filters:

```
ruby batting_average.rb --file stats.csv
```

You can also filter by either year, team or both:

```
ruby batting_average.rb --file stats.csv --year 2017 --team 'Philadelphia Phillies'
```

To run specs:

```
bundle && rspec spec
```
