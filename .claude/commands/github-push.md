---
description: Push to GitHub with safety checks, README refresh, Pages deployment setup
---

# GitHub Push Workflow

Execute the complete GitHub push workflow with the following steps:

1. **Pre-flight Safety Checks**
   - Verify `.gitignore` exists and contains common secret patterns (`.env`, `.env.local`, `*.key`, `*.pem`, `secrets/`, etc.)
   - Scan staged files for potential secrets (API keys, tokens, passwords, private keys)
   - Check for large files that shouldn't be committed
   - Warn if any suspicious patterns are found

2. **Refresh Documentation**
   - Invoke the `/readme` command to regenerate README.md with current project state

3. **GitHub Actions Deployment Setup**
   - Create `.github/workflows/deploy.yml` that:
     - Triggers on push to main branch
     - Uses actions/checkout@v4
     - Sets up Node.js
     - Installs dependencies
     - Builds the Next.js static export
     - Uses actions/upload-pages-artifact@v3 to upload the build
     - Uses actions/deploy-pages@v4 to deploy to GitHub Pages
     - Configures proper permissions for Pages deployment

4. **Commit and Push**
   - Stage all changes (including README.md and workflow file)
   - Create a clear, descriptive commit message
   - Push to origin/main

5. **GitHub Pages Configuration**
   - Enable GitHub Pages via `gh api` with `build_type=workflow`
   - Configure Pages to deploy from GitHub Actions

6. **Repository Metadata**
   - Set repository description (describe this as a pole fitness training app)
   - Add relevant topics: `nextjs`, `fitness`, `pole-fitness`, `progressive-web-app`, `react`
   - Set homepage URL to the GitHub Pages URL

7. **Output**
   - Print the live GitHub Pages URL
   - Confirm all steps completed successfully

**IMPORTANT**:
- Stop and warn the user if any secrets are detected
- Do not proceed with commit/push if critical issues are found
- Ensure the Next.js app is configured for static export (`output: 'export'` in next.config.js)
- Verify the build succeeds before pushing
