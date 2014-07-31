# Redmine Default Custom Query Plugin

Redmine plugin for setting the default custom query to issues list per projects.

## NOTICE

This plugin has no test code yet, so there may be a lot of bugs.  
I have a plan to release version 0.1.0 to write test code in this weekend (maybe).

## Supported versions

  * Redmine 2.3.x, 2.4.x, 2.5.x
  * Ruby 1.9.3, 2.0.0

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
