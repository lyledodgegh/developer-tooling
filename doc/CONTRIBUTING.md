# Contributing to Developer Tooling

Thank you for your interest in contributing to this project! This document provides guidelines for contributing.

## How to Contribute

### Reporting Issues

If you encounter a problem:

1. Check if the issue already exists in the GitHub issue tracker
2. If not, create a new issue with:
   - A clear, descriptive title
   - Detailed description of the problem
   - Steps to reproduce
   - Expected vs actual behavior
   - Your operating system and version
   - Any relevant error messages

### Suggesting Enhancements

To suggest a new feature or tool:

1. Open an issue with the "enhancement" label
2. Describe the tool or feature you'd like to add
3. Explain why it would be useful
4. If possible, provide links to the tool's official documentation

### Contributing Code

1. **Fork the repository**
2. **Create a feature branch** from `main`
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes** following the guidelines below
4. **Test your changes** thoroughly
5. **Commit your changes** with clear, descriptive commit messages
6. **Push to your fork**
7. **Create a Pull Request**

## Coding Guidelines

### Bash Script Guidelines

1. **Use consistent formatting**
   - Use 4 spaces for indentation (no tabs)
   - Keep lines under 100 characters when possible
   - Use meaningful variable names

2. **Error handling**
   - Check return codes of commands
   - Provide clear error messages
   - Use `set -e` to exit on errors when appropriate

3. **Function structure**
   - Each tool installation should be a separate function
   - Functions should echo what they're doing
   - Functions should report errors clearly
   - Example:
     ```bash
     install_nodejs() {
         echo "Installing Node.js..."
         if brew install node; then
             echo "✓ Node.js installed successfully"
         else
             echo "✗ Failed to install Node.js"
             return 1
         fi
     }
     ```

4. **Comments**
   - Add comments for complex logic
   - Document function parameters
   - Explain non-obvious decisions

5. **Testing**
   - Update test scripts when adding new tools
   - Verify installations work correctly
   - Test on target platforms when possible

### Adding New Tools

When adding a new tool to the installation scripts:

1. **Research the official installation method**
   - Prefer package manager installation (brew/apt)
   - Follow the tool's recommended installation practices
   - Note any dependencies

2. **Create an installation function**
   ```bash
   install_toolname() {
       echo "Installing ToolName..."
       # Installation logic here
       if command -v toolname &> /dev/null; then
           echo "✓ ToolName installed successfully"
           return 0
       else
           echo "✗ Failed to install ToolName"
           return 1
       fi
   }
   ```

3. **Add to appropriate category function**
   - Add your tool to the relevant developer category
   - Update the "install all" function
   - Update the "update all" function

4. **Add verification to test script**
   ```bash
   test_toolname() {
       echo -n "Testing ToolName... "
       if command -v toolname &> /dev/null; then
           echo "✓ OK"
           return 0
       else
           echo "✗ NOT FOUND"
           return 1
       fi
   }
   ```

5. **Update documentation**
   - Add the tool to the appropriate section in `/doc/README.md`
   - Document any special configuration needed

### Platform-Specific Considerations

#### macOS Scripts
- Use Homebrew for package management
- Test on multiple macOS versions if possible
- Consider both Intel and Apple Silicon

#### WSL/Linux Scripts
- Use apt for package management
- Consider Ubuntu LTS versions
- Test that installations work in WSL environment

## Pull Request Process

1. Ensure your code follows the style guidelines
2. Update documentation to reflect your changes
3. Add or update tests as needed
4. Ensure all tests pass
5. Update the README.md if you're adding new functionality
6. The PR will be reviewed by maintainers
7. Address any feedback from reviewers
8. Once approved, your PR will be merged

## Code of Conduct

- Be respectful and inclusive
- Focus on constructive feedback
- Help others learn and grow
- Maintain a positive community

## Questions?

If you have questions about contributing, please open an issue with the "question" label.

Thank you for contributing!
