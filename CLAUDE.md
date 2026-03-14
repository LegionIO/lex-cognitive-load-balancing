# lex-cognitive-load-balancing

**Level 3 Leaf Documentation**
- **Parent**: `/Users/miverso2/rubymine/legion/extensions-agentic/CLAUDE.md`

## Purpose

Multi-subsystem cognitive load distribution engine. Registers named cognitive subsystems (perception, reasoning, memory, attention, language, planning, motor, emotional), assigns and sheds load on individual subsystems, and rebalances when overloaded subsystems exist alongside underloaded ones. Complements `lex-cognitive-load` (which tracks a single agent's three-component load) by modeling the distribution of work across specialized functional subsystems.

## Gem Info

- **Gem name**: `lex-cognitive-load-balancing`
- **Module**: `Legion::Extensions::CognitiveLoadBalancing`
- **Version**: `0.1.0`
- **Ruby**: `>= 3.4`
- **License**: MIT

## File Structure

```
lib/legion/extensions/cognitive_load_balancing/
  version.rb
  client.rb
  helpers/
    constants.rb
    subsystem.rb
    load_balancer.rb
  runners/
    cognitive_load_balancing.rb
```

## Key Constants

| Constant | Value | Purpose |
|---|---|---|
| `MAX_SUBSYSTEMS` | `50` | Per-engine subsystem capacity |
| `MAX_TASKS` | `500` | Per-engine task capacity |
| `DEFAULT_CAPACITY` | `1.0` | Default subsystem load ceiling |
| `OVERLOAD_THRESHOLD` | `0.85` | Utilization above which subsystem is overloaded |
| `UNDERLOAD_THRESHOLD` | `0.2` | Utilization below which subsystem is underloaded |
| `REBALANCE_STEP` | `0.1` | Amount transferred per rebalance operation |
| `SUBSYSTEM_TYPES` | `%i[perception reasoning memory attention language planning motor emotional]` | Valid types |
| `LOAD_LABELS` | range hash | From `:idle` to `:saturated` |
| `HEALTH_LABELS` | range hash | From `:critical` to `:optimal` |

## Helpers

### `Helpers::Subsystem`
Single cognitive subsystem with `id`, `name`, `subsystem_type`, `current_load`, and `capacity`.

- `utilization` — `current_load / capacity`
- `load_label`
- `overloaded?` — utilization > `OVERLOAD_THRESHOLD`
- `underloaded?` — utilization < `UNDERLOAD_THRESHOLD`
- `health` — inverse of utilization (lower utilization = better health)
- `health_label`
- `add_load!(amount)` — increases current load (clamped to capacity)
- `shed_load!(amount)` — decreases current load (floor 0)
- `available_capacity` — capacity minus current load

### `Helpers::LoadBalancer`
Multi-subsystem coordinator.

- `register_subsystem(name:, subsystem_type:, capacity:)` → subsystem or capacity error
- `assign_load(subsystem_id:, amount:)` → subsystem state
- `shed_load(subsystem_id:, amount:)` → subsystem state
- `auto_assign(amount:)` → assigns to subsystem with minimum utilization
- `rebalance` → transfers `REBALANCE_STEP` from each overloaded subsystem to each underloaded one
- `overloaded_subsystems` → list of overloaded subsystem hashes
- `underloaded_subsystems` → list of underloaded subsystem hashes
- `subsystems_by_type(type:)` → filtered list
- `most_loaded` → subsystem with highest utilization
- `overall_utilization` → mean utilization across all subsystems
- `overall_health` → mean health across all subsystems
- `balance_report` → aggregate stats hash

## Runners

Module: `Runners::CognitiveLoadBalancing`

| Runner Method | Description |
|---|---|
| `register_cognitive_subsystem(name:, subsystem_type:, capacity:)` | Register a subsystem |
| `assign_cognitive_load(subsystem_id:, amount:)` | Assign load to subsystem |
| `shed_cognitive_load(subsystem_id:, amount:)` | Remove load from subsystem |
| `auto_assign_load(amount:)` | Auto-assign to least-loaded subsystem |
| `rebalance_cognitive_load` | Transfer load from overloaded to underloaded |
| `overloaded_subsystems_report` | List overloaded subsystems |
| `most_loaded_report` | Most loaded subsystem |
| `cognitive_load_balance_report` | Full balance stats |
| `cognitive_load_balancing_stats` | Aggregate statistics |

All runners return `{success: true/false, ...}` hashes.

## Integration Points

- Complements `lex-cognitive-load` (three-component per-agent model) with cross-subsystem distribution
- `auto_assign_load` called from `lex-tick` `action_selection` phase to route task to least-busy subsystem
- `rebalance` is a natural periodic maintenance operation (integrate with `lex-tick` dormant or sentinel phase)
- Subsystem health scores can contribute to `lex-emotion` valence

## Development Notes

- `Client` instantiates `@load_balancer = Helpers::LoadBalancer.new`
- `auto_assign` picks the subsystem with minimum utilization — ties broken by insertion order
- `rebalance` makes one pass over overloaded/underloaded pairs per call; multiple calls may be needed for severe imbalance
- `REBALANCE_STEP = 0.1` is defined but callers should call `rebalance` iteratively for large imbalances
- `MAX_TASKS = 500` is defined in constants but tracked separately from subsystem load (future task-assignment tracking)
