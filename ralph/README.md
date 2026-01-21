# Ralph Slash Commands

Slash commands for creating and managing Ralph agent PRDs (Product Requirements Documents).

## Commands

### /make-ralph-PRD

Creates a PRD from a spec file, collects user feedback, and generates a ralph.md execution file.

**Workflow:**
1. Asks for spec file path
2. Reads and analyzes the spec
3. Generates a structured PRD with user stories
4. Saves as `{spec-name}.prd.json`
5. Solicits feedback and approval from user
6. Generates `{spec-name}.ralph.md` for agent execution

**PRD Structure:**
- **meta**: Project metadata, version, goal, and notes
- **stories**: Array of user stories with:
  - Unique ID (e.g., NOTES-001)
  - Title and description (in "As a... I want... so..." format)
  - Specific requirements
  - Testable acceptance criteria
  - Status (todo, in_progress, done)
  - Priority (high, medium, low)
  - Dependencies (depends_on)

**Key Principles:**
- Stories must be small, independent, and testable
- Each story should be completable by an agent in isolation
- Dependencies ensure proper build order
- Start with foundation/skeleton, then build features incrementally

## Running Ralph

After generating the ralph.md file, execute it with:

```bash
AWS_PROFILE=cf2 ralph \
  --prompt-file specs/{spec-name}.ralph.md \
  --completion-promise "COMPLETE" \
  --max-iterations 50 \
  --model amazon-bedrock/anthropic.claude-opus-4-5-20251101-v1:0
```

## Example PRD

See `/ralph/make-ralph-PRD.md` for a complete example of the notes app PRD structure.

## Installation

These slash commands are automatically available when you have this repository set up with OpenCode.

To invoke the command:
```
/make-ralph-PRD
```
