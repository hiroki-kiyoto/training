# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

- Ruby version 2.5.1

- Rails version 5.2.3

- Database creation mysql version 5.6

# DB設計

## projects
| column | type |option |
|----|---- |----|
| id |  |  |
| name | string | null:false |

### Asociation
has_many :tasks

## tasks
| column | type |option |
|----|---- |----|
| id |  |  |
| title | string | null:false |
| deadline | date |  |
| comment | text |  |
| project | references | foreign_key |

### Asociation
belongs_to :project 

has_many :task_tags, dependent: :destroy

has_many :tags, through: :task_tags , source: :tags

## task_tags
| column | type |option |
|----|---- |----|
| id |  |  |
| task | references | foreign_key |
| tag | references | foreign_key |

### Asociation
belongs_to :task

belongs_to :tag

## tags
| column | type |option |
|----|---- |----|
| id |  |  |
| tags_name | string | null:false |

### Asociation
has_many :task_tags, dependent: :destroy
