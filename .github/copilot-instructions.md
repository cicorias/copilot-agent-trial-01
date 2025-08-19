# Copilot Agent Trial Swift Project

This is a Swift project repository for testing Copilot agent functionality. The repository currently contains minimal setup but is prepared for Swift development.

Always reference these instructions first and fallback to search or bash commands only when you encounter unexpected information that does not match the info here.

## Working Effectively

### Initial Setup and Environment
- Verify Swift is installed: `swift --version`
  - Expected output: Swift version 6.1+ on Linux
  - If not installed, Swift is typically pre-installed in this environment
- Check Swift Package Manager: `swift package --help`

### Project Initialization (if starting fresh)
- Initialize a new Swift package: `swift package init --type [executable|library]`
  - Takes ~1 second to complete
  - Creates Package.swift, Sources/, and basic project structure
- For library projects: `swift package init --type library`
- For executable projects: `swift package init --type executable`

### Building and Testing
- Build the project: `swift build`
  - NEVER CANCEL: Initial build takes 10-15 seconds for basic projects. Set timeout to 60+ seconds.
  - Subsequent builds are typically faster (1-5 seconds)
  - Creates .build/ directory with compiled artifacts
- Run the executable (if applicable): `swift run`
  - Takes 1-3 seconds after initial build
  - Will rebuild if source changes detected
- Run tests: `swift test`
  - NEVER CANCEL: Test execution takes 5-15 seconds depending on test count. Set timeout to 60+ seconds.
  - Note: Will show "no tests found" error if Tests/ directory doesn't exist

### Code Quality and Linting
- Install SwiftLint for code quality (recommended):
  ```bash
  curl -fsSL https://github.com/realm/SwiftLint/releases/latest/download/swiftlint_linux.zip -o /tmp/swiftlint.zip
  cd /tmp && unzip -o -q swiftlint.zip && chmod +x swiftlint
  sudo mv swiftlint /usr/local/bin/
  ```
  - Download takes 10-30 seconds depending on connection
  - Use `-o` flag with unzip to overwrite existing files
  - Always run `swiftlint` in project root before committing changes
- SwiftLint usage:
  - Check code style: `swiftlint`
  - Auto-fix issues: `swiftlint --fix`
  - Example output: "Found 1 violation, 0 serious in 2 files" indicates style issues to fix

### Development Workflow
- Always build before testing: `swift build && swift test`
- For iterative development: `swift run` rebuilds automatically when needed
- Clean builds when needed: `swift package clean && swift build`
  - Clean operation takes 1-2 seconds
  - Full rebuild after clean takes 10-20 seconds for typical projects

## Validation

### Pre-commit Validation Steps
- ALWAYS run these commands before committing changes:
  1. `swift build` -- ensure compilation succeeds
  2. `swift test` -- run all tests (if tests exist)
  3. `swiftlint` -- check code style (if SwiftLint is installed)
- ALWAYS test actual functionality by running the executable with `swift run` if it's an executable project
- For library projects, create a simple test program to verify the library works as expected

### Manual Testing Scenarios
- For executable projects: Run `swift run` and verify the program produces expected output
- For library projects: Import the library in a test project and verify key functionality
- Always test edge cases and error conditions when making changes
- Verify that any public APIs work as documented

## Project Structure

### Current Repository State
- Contains .gitignore (Swift/iOS template) and Swift executable project
- Ready for Swift development with Package.swift and Sources/main.swift
- Project name: "copilot-agent-trial-01" 
- Includes working "Hello, world!" executable
- Build tested and functional - all commands validated

### Expected Project Layout (when code is added)
```
├── Package.swift              # Swift Package Manager manifest
├── Sources/                   # Source code directory
│   ├── [ModuleName]/         # Main module (for libraries)
│   └── main.swift            # Entry point (for executables)
├── Tests/                     # Test directory
│   └── [ModuleName]Tests/    # Test files
├── .gitignore                # Swift/iOS gitignore (already present)
└── README.md                 # Project documentation
```

### Key Files to Monitor
- `Package.swift` - Defines dependencies, targets, and Swift version requirements
- `Sources/main.swift` - Entry point for executable projects
- `Sources/[ModuleName]/` - Main library code for library projects
- `Tests/` - All test files and test targets

## Common Tasks

### Adding Dependencies
- Edit `Package.swift` to add dependencies in the `dependencies` array
- Run `swift package resolve` to fetch dependencies
  - NEVER CANCEL: Dependency resolution can take 30-120 seconds for complex dependency graphs. Set timeout to 180+ seconds.
- Dependencies are cached in `.build/` directory

### Creating Tests
- Add test files in `Tests/[ModuleName]Tests/` directory
- Test files should import `XCTest` and the module being tested
- Run specific test: `swift test --filter [TestName]`

### Release Builds
- Build for release: `swift build -c release`
  - NEVER CANCEL: Release builds take 20-60 seconds due to optimizations. Set timeout to 120+ seconds.
- Release binaries located in `.build/release/`

## Platform and Environment Notes

### Current Environment
- Running Swift 6.1+ on Linux x86_64
- Swift Package Manager available
- SwiftLint available via manual installation
- No Xcode available (Linux environment)

### iOS Development Limitations
- This environment supports Swift but not iOS-specific development
- Cannot build iOS apps or use iOS simulators
- Focus on Swift Package Manager projects and command-line tools
- For iOS development, use macOS with Xcode

### Performance Expectations
- Package initialization: ~1 second
- Clean build (small project): 10-15 seconds
- Incremental build: 1-5 seconds  
- Test execution: 5-15 seconds
- Dependency resolution: 30-120 seconds
- Release build: 20-60 seconds

## Troubleshooting

### Common Issues
- "No tests found" error: Create Tests/ directory and add test files
- Build failures: Check Swift version compatibility in Package.swift
- Dependency issues: Run `swift package clean && swift package resolve`
- Permission errors: Ensure write access to .build/ directory

### Recovery Commands
- Clean and rebuild: `swift package clean && swift build`
- Reset dependencies: `swift package reset && swift package resolve`
- Update dependencies: `swift package update`

## Best Practices
- Always use semantic versioning for package releases
- Include comprehensive tests for all public APIs
- Document public interfaces with Swift documentation comments
- Use SwiftLint configuration file (.swiftlint.yml) for consistent code style
- Commit Package.resolved for reproducible builds
- Never commit .build/ directory contents (already in .gitignore)