# Rule: Generating a GitHub Comment Summary from a Task List

## Goal

To guide an AI assistant in producing a concise, well-formatted GitHub comment that summarizes implementation progress based on a task list Markdown file (and optional PRD). The comment should be suitable for posting on a Pull Request or Issue.

## Output

* **Format:** Markdown (`.md`)
* **Location:** `/tasks/`
* **Filename:** `comment-[tasks-file-name].md`
  *(e.g., `comment-tasks-0001-prd-user-profile-editing.md`)*

## Inputs

* **Required:** Path to the **task list** file (e.g., `/tasks/tasks-0001-prd-user-profile-editing.md`).
* **Optional:** Path to the **PRD** file (e.g., `/tasks/0001-prd-user-profile-editing.md`) for context.

## Process

1. **Receive References**

   * The user provides the task list path and, optionally, the PRD path.

2. **Parse Task List**

   * Identify **parent tasks** and **sub-tasks**.
   * Mark completion states by parsing `[ ]` and `[x]`.
   * Compute:

     * **Sub-task completion %** per parent task and overall.
     * Count of completed vs total for parents and sub-tasks.

3. **Extract Relevant Files**

   * From the `## Relevant Files` section (if present), list files and their one-line descriptions.
   * If not present, omit this section from the comment.

4. **Summarize Progress**

   * Highlight:

     * Newly completed parent tasks (all subtasks `[x]`).
     * Notable sub-tasks completed since last update (if detectable; otherwise list the top N completed sub-tasks).
   * Note any **remaining** parent tasks and their next unstarted sub-task.

5. **Surface Risks/Blockers**

   * From any “Notes”/“Blockers” sections in the task list (if present), or ask the user to confirm blockers if unclear.

6. **Quality Gates**

   * If the task list indicates all subtasks under a parent are `[x]`, ensure the **completion protocol** was followed (tests run, staged, cleaned, committed). If not explicitly recorded, add a gentle reminder in the comment.

7. **Generate Comment**

   * Produce a GitHub-friendly Markdown comment using the template in **Output Format**.

8. **Save Comment**

   * Save the generated comment as `comment-[tasks-file-name].md` in `/tasks/`.

9. **Present & Confirm**

   * Show the comment to the user and **ask for confirmation** before posting it anywhere outside the repo.

## Output Format

The generated comment **must** follow this structure:

```markdown
### Implementation Summary

**PRD:** [link or filename if provided]  
**Task List:** [filename]

**Overall Progress:** {completed_subtasks}/{total_subtasks} sub-tasks — **{percent}%** complete

---

#### Parent Task Status
- **{1.0 Parent Title}** — {completed}/{total} sub-tasks ({percent}%)
- **{2.0 Parent Title}** — {completed}/{total} sub-tasks ({percent}%)
- ...

---

#### Recently Completed Highlights
- [x] {sub-task id} {sub-task title/summary}
- [x] {sub-task id} {sub-task title/summary}
- ...

#### Next Up
- [ ] {next sub-task id} {next sub-task title/summary}

---

#### Relevant Files (from task list)
- `{path/to/file}` — {one-line purpose}
- `{path/to/another}` — {one-line purpose}
- ...

---

#### Tests & Quality Gates
- Test suite: {Ran / Not recorded}  
- Staging & cleanup: {Done / Not recorded}  
- Commit(s): {short summary or N/A}

---

#### Risks / Blockers
- {brief itemized list or “None reported”}

> Generated from `{tasks-file-name}` on {YYYY-MM-DD}. Please reply **“Post”** to confirm publishing this as a PR comment.
```

## Notes

* Keep the summary under ~300–400 words to remain scannable in GitHub.
* Use **clear, neutral** language; avoid implementation details beyond what’s in the task list.
* If links are available (PRD or files in the repo), include them; otherwise use filenames.

## Interaction Model

1. **Ask for the task list path** (and optional PRD path) if not provided.
2. **Show the generated comment** and wait for user confirmation:

   * User replies **“Post”** to proceed with publishing (outside this rule’s scope), or
   * User replies **“Edit”** with instructions to adjust the comment content.
3. **Update** the saved `/tasks/comment-[tasks-file-name].md` if the user requests changes.

## Target Audience

Assume the primary reader is a **reviewer on GitHub** and the **junior developer** executing the tasks. The comment should quickly convey progress, what just got done, what’s next, and any risks.