# AI Dev Tasks — Quick Guide

## Available Rules

- **`create-prd.md`** - Generate Product Requirements Documents for new features
- **`generate-task.md`** - Create detailed task lists from PRDs with subtasks
- **`process-task-list.md`** - Manage task implementation with progress tracking
- **`github-summary.md`** - Create Git commit summaries and change documentation

## 5-Step Workflow for Complete Feature Development

1. **Create the PRD (Product Requirement Document)**
   Define what you're going to build, for whom and why. Use `create-prd.md`.
   ```
   Use @create-prd.md
   Here's the feature I want to build: [Describe your feature in detail]
   Reference these files to help you: [Optional: @file1.py @file2.ts]
   ```

2. **Generate task list**
   From the PRD, break down the work into concrete tasks. Use `generate-task.md`.
   ```
   Use @generate-task.md
   Here's the PRD: [Paste your PRD content]
   Generate a detailed task list for this feature.
   ```

3. **Process the task list**
   Tell the agent to start with task 1, advance one by one and wait for your approval. Use `process-task-list.md`.
   ```
   Use @process-task-list.md
   Here's the task list: [Paste your task list]
   Start with task 1 and work through each task systematically.
   ```

4. **Review and approve each task**
   For each result, review: if it's good → approve and advance; if not → request corrections.
   ```
   Use @process-task-list.md
   Task 1 is complete. Please review the implementation and approve to continue with task 2.
   ```

5. **Generate changes summary (Optional but recommended)**
   Create a comprehensive summary of all changes for better Git commits and documentation.
   ```
   Use @github-summary.md
   Here's the completed task list: [Paste your task list with completed tasks]
   Generate a changes summary for Git commits.
   ```

---

## Example Usage

```
Use @create-prd.md
Here's the feature I want to build: A user authentication system that allows users to register, login, and manage their profiles securely.
Reference these files to help you: @app/Models/User.php @app/Http/Controllers/AuthController.php
```

## File Organization

Generated files are saved in the `/tasks/` directory:
- `[n]-prd-[feature-name].md` - Product Requirements Documents
- `tasks-[prd-file-name].md` - Task lists with subtasks
- `tasks-[task-file-name]-changes.md` - Changes summaries for Git

## Integration with Git Workflow

After completing tasks, use the changes summary to:
- Create meaningful commit messages following conventional commit format
- Document changes for code reviews
- Track feature implementation progress
- Generate release notes or PR descriptions

