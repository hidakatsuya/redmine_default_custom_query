# Redmine Default Custom Query [![Gitter](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/hidakatsuya/redmine_default_custom_query?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge)


[![Build Status](http://img.shields.io/travis/hidakatsuya/redmine_default_custom_query.svg?style=flat)](https://travis-ci.org/hidakatsuya/redmine_default_custom_query)
[![Code Climate](http://img.shields.io/codeclimate/github/hidakatsuya/redmine_default_custom_query.svg?style=flat)](https://codeclimate.com/github/hidakatsuya/redmine_default_custom_query)

Redmine plugin for setting the default custom query of Issues for each project.

![Configure the default query per projects](https://raw.githubusercontent.com/wiki/hidakatsuya/redmine_default_custom_query/images/select-default-query-per-projects.png)

![Apply the default query](https://raw.githubusercontent.com/wiki/hidakatsuya/redmine_default_custom_query/images/issues-with-default-query.png)

## Usage

  1. Enable the Default Custom Query module in your project
  2. Select a custom query to set to default in setting for your project

## Supported versions

  * Redmine 3.1, 3.2, 3.3
  * Ruby 2.2, 2.3

INFO: [1.1.x](http://www.redmine.org/plugins/redmine_default_custom_query) supports Redmine 2.x and Ruby 1.9.3.

## Install

`git clone` or copy an unarchived plugin(archived file is [here](https://github.com/hidakatsuya/redmine_default_custom_query/releases)) to `plugins/redmine_default_custom_query` on your Redmine path.

```
$ git clone https://github.com/hidakatsuya/redmine_default_custom_query.git /path/to/your-redmine/plugins/redmine_default_custom_query
```

Then, migrate:

```
$ cd /path/to/your-redmine
$ rake redmine:plugins:migrate NAME=redmine_default_custom_query RAILS_ENV=production
```

That's all.

## Uninstall

At first, rollback schema:

```
$ cd /path/to/your-redmine
$ rake redmine:plugins:migrate NAME=redmine_default_custom_query VERSION=0 RAILS_ENV=production
```

Then, remove `plugins/redmine_default_custom_query` directory.

## Contribute

### How to test

```
$ cd /path/to/redmine
$ bundle install
$ bundle exec rake redmine:plugins:test NAME=redmine_default_custom_query
```

### Pull Request

  1. Fork it
  2. Create your feature branch: `git checkout -b new-feature`
  3. Commit your changes: `git commit -am 'add some new feature'`
  4. Push to the branch: `git push origin new-feature`
  5. Create new Pull Request

### Report bugs

Please report from [here](https://github.com/hidakatsuya/redmine_default_custom_query/issues/new).

## Copyright

&copy; Katsuya Hidaka. See MIT-LICENSE for further details.
