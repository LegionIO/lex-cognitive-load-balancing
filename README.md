# lex-cognitive-load-balancing

Multi-subsystem cognitive load distribution for LegionIO cognitive agents. Registers named cognitive subsystems (perception, reasoning, memory, attention, language, planning, motor, emotional) and intelligently distributes work to maintain optimal utilization.

## What It Does

- Register up to 50 cognitive subsystems with individual capacity limits
- Assign and shed load on specific subsystems
- Auto-assign tasks to the least-loaded subsystem
- Rebalance: automatically transfers load from overloaded to underloaded subsystems
- Track per-subsystem utilization, health, and load labels
- Report overall system balance and identify bottlenecks

## Usage

```ruby
# Register subsystems
runner.register_cognitive_subsystem(name: 'primary_reasoning',
                                     subsystem_type: :reasoning, capacity: 1.0)
runner.register_cognitive_subsystem(name: 'working_memory',
                                     subsystem_type: :memory, capacity: 0.8)

# Assign load to a specific subsystem
runner.assign_cognitive_load(subsystem_id: id, amount: 0.4)

# Auto-assign to least-loaded
runner.auto_assign_load(amount: 0.2)
# => { success: true, subsystem_id: '...', utilization: 0.XX }

# Rebalance when overloaded subsystems exist
runner.rebalance_cognitive_load
# => { success: true, rebalanced: true, overloaded_count: 0, underloaded_count: 1 }

# Check for bottlenecks
runner.overloaded_subsystems_report

# Full balance report
runner.cognitive_load_balance_report
# => { success: true, total_subsystems: 2, overall_utilization: 0.XX, overall_health: 0.XX, ... }
```

## Development

```bash
bundle install
bundle exec rspec
bundle exec rubocop
```

## License

MIT
