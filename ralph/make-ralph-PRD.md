# make-ralph-PRD

Create a Product Requirements Document (PRD) for Ralph agent execution.

## Instructions

You are helping the user create a PRD that will be used by the Ralph agent to implement a feature through small, independent, testable stories.

### Step 1: Get the spec file
Ask the user for the spec file path that contains the project requirements. Read the spec file to understand what needs to be built.

### Step 2: Analyze and create PRD
Based on the spec file, create a comprehensive PRD following this structure:

```json
{
  "meta": {
    "project": "Project Name",
    "version": 1,
    "goal": "High-level goal statement",
    "notes": "Important notes about story structure and constraints"
  },
  "stories": [
    {
      "id": "PREFIX-001",
      "title": "Story title",
      "description": "As a [role], I want [feature] so [benefit].",
      "requirements": [
        "Specific requirement 1",
        "Specific requirement 2",
        "Specific requirement 3"
      ],
      "acceptance_criteria": [
        "Testable criterion 1",
        "Testable criterion 2",
        "Testable criterion 3"
      ],
      "status": "todo",
      "priority": "high|medium|low",
      "depends_on": ["PREFIX-001"]
    }
  ]
}
```

### Key Principles for Story Creation:

1. **Small and Independent**: Each story should be completable in isolation by an agent
2. **Testable**: Acceptance criteria must be clear and verifiable
3. **Sequential**: Use `depends_on` to enforce proper build order
4. **Progressive**: Start with skeleton/foundation, then add features incrementally
5. **Specific**: Requirements should be concrete, not vague

### Story Priority Guidelines:
- **high**: Core functionality, blocking other work, or critical path items
- **medium**: Important features that depend on high-priority items
- **low**: Nice-to-have features, optimizations, or polish

### Step 3: Save the PRD
Save the PRD to `{spec-name}.prd.json` where `{spec-name}` is derived from the spec file name (without extension).

### Step 4: Solicit Feedback
Present the PRD to the user and ask:
1. Are the stories sized appropriately (small enough for an agent to complete)?
2. Are dependencies clear and correct?
3. Are there any missing stories or edge cases?
4. Should priorities be adjusted?

Allow the user to iterate on the PRD until they approve it.

### Step 5: Generate Ralph Execution File
Once approved, create `{spec-name}.ralph.md` with the Ralph agent prompt. This file should:
- Reference the PRD file
- Contain instructions for the Ralph agent to execute stories sequentially
- Include completion criteria
- Specify testing and validation steps

The ralph.md file is designed to be run with:
```bash
AWS_PROFILE=cf2 ralph --prompt-file specs/{spec-name}.ralph.md --completion-promise "COMPLETE" --max-iterations 50 --model amazon-bedrock/anthropic.claude-opus-4-5-20251101-v1:0
```

### Example Ralph.md Structure:

```markdown
# Project Implementation: {Project Name}

You are Ralph, an autonomous agent tasked with implementing the project defined in `{spec-name}.prd.json`.

## Your Mission
Execute each story in the PRD sequentially, following dependencies. 

**IMPORTANT: Complete ONE story per iteration.**

For each story:

1. Read the story requirements and acceptance criteria
2. Implement the story using best practices
3. Test the implementation against acceptance criteria
4. Mark the story as complete in the PRD (update status to "done")
5. Move to the next story in the next iteration

## Rules
- **ONE STORY PER ITERATION** - Complete a single story, then end the iteration
- Only work on stories where all dependencies are complete
- Follow the acceptance criteria exactly
- Write tests where specified
- Update the PRD status field as you progress
- If blocked, document the blocker and continue with independent stories

## Completion
**CRITICAL**: Only output the word "COMPLETE" when ALL stories have status "done".

Do NOT say "COMPLETE" after finishing individual stories. Only say "COMPLETE" when the entire PRD is finished.

## PRD Reference
The full PRD is available at: {spec-name}.prd.json
```

### Important Notes:
- Always validate that the spec file exists before proceeding
- Ensure story IDs are unique and follow a consistent pattern
- Verify dependency chains don't create cycles
- Make sure the first few stories establish the foundation (routes, pages, basic structure)
- Later stories should build features on top of the foundation
