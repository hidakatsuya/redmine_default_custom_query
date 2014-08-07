# Redmine Default Custom Query

[![Build Status](https://travis-ci.org/hidakatsuya/redmine_default_custom_query.svg)](https://travis-ci.org/hidakatsuya/redmine_default_custom_query)
[![Code Climate](https://codeclimate.com/github/hidakatsuya/redmine_default_custom_query/badges/gpa.svg)](https://codeclimate.com/github/hidakatsuya/redmine_default_custom_query)

Redmine plugin for setting the default custom query to issues per projects.

![Configure the default query per projects](https://raw.githubusercontent.com/wiki/hidakatsuya/redmine_default_custom_query/images/select-default-query-per-projects.png)

![Apply the default query](https://raw.githubusercontent.com/wiki/hidakatsuya/redmine_default_custom_query/images/issues-with-default-query.png)

## Usage

  1. Enable the default custom query module in your project settings
  2. Setting the default query to open the "Default custom query" tab

## Supported versions

  * Redmine 2.3.x, 2.4.x, 2.5.x
  * Ruby 1.9.3, 2.1.1

## Installation

`git clone` or copy unarchive (an archive file is  [here](https://github.com/hidakatsuya/redmine_default_custom_query/releases)) plugin to `plugins/redmine_default_custom_query` on your Redmine path.

```
$ git clone https://github.com/hidakatsuya/redmine_issue_wiki_journal.git /path/to/your-redmine/plugins
```

Then, migrate:

```
$ cd /path/to/your-redmine
$ rake redmine:plugins:migrate NAME=redmine_default_custom_query
```

That's all.

## Uninstallation

At first, rollback schema:

```
$ cd /path/to/your-redmine
$ rake redmine:plugins:migrate NAME=redmine_default_custom_query VERSION=0
```

Then, remove `plugins/redmine_default_custom_query` directory.

## Contributing

### Pull Request

  1. Fork it
  2. Create your feature branch: `git checkout -b new-feature`
  3. Commit your changes: `git commit -am 'add some new feature'`
  4. Push to the branch: `git push origin new-feature`
  5. Create new Pull Request

### Report bugs

Please report [here](https://github.com/hidakatsuya/redmine_default_custom_query/issues/new).

## Copyright

&copy; Katsuya Hidaka. See MIT-LICENSE for further details.
