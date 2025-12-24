# Contributing to SAP Learning Hub

Thank you for your interest in contributing to the SAP Learning Hub! This document provides guidelines for contributing to this project.

## How to Contribute

### Reporting Issues

- Use the GitHub issue tracker
- Clearly describe the issue
- Include steps to reproduce
- Mention your environment (Node.js version, SAP system version, etc.)

### Suggesting Enhancements

- Open an issue with the "enhancement" label
- Clearly describe the proposed feature
- Explain why it would be useful

### Code Contributions

1. **Fork the Repository**
   ```bash
   git fork https://github.com/RJTechRamjee/SAPLearningHub.git
   ```

2. **Create a Feature Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Your Changes**
   - Follow existing code style
   - Add comments where necessary
   - Update documentation

4. **Test Your Changes**
   - Test CAP changes with `npm run watch`
   - Test ABAP changes in your SAP system
   - Ensure no breaking changes

5. **Commit Your Changes**
   ```bash
   git commit -m "Add: Brief description of your changes"
   ```

6. **Push to Your Fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Create a Pull Request**
   - Describe your changes
   - Reference any related issues
   - Wait for review

## Coding Guidelines

### CAP/JavaScript
- Use 2 spaces for indentation
- Follow the existing code structure
- Use meaningful variable and function names
- Add JSDoc comments for functions

### ABAP
- Follow Clean ABAP guidelines
- Use modern ABAP syntax
- Add meaningful comments
- Follow SAP naming conventions (Z* or Y* prefix)

### Documentation
- Use clear, concise language
- Include code examples
- Update README files when adding features
- Keep documentation in sync with code

## Types of Contributions

### Code Examples
- Add new CAP service examples
- Add ABAP code samples
- Integration examples

### Documentation
- Tutorial improvements
- New learning guides
- Best practices documentation

### Configuration
- Development tool configurations
- Deployment scripts
- CI/CD improvements

## Questions?

Feel free to open an issue for any questions about contributing.

Thank you for contributing to SAP Learning Hub! 🙏
