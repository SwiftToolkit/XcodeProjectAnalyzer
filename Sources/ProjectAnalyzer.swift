// The Swift Programming Language
// https://docs.swift.org/swift-book
// 
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import PathKit
import XcodeProj

@main
struct ProjectAnalyzer: ParsableCommand {
    @Option(transform: { argument in Path.current + argument })
    var path: Path

    func run() throws {
        print("Analyzing .xcodeproj at:", path)

        let xcodeProj = try XcodeProj(path: path)
        try xcodeProj.pbxproj.projects.forEach { pbxProject in
            print("Project \(pbxProject.name):")
            print("\t・\(pbxProject.remotePackages.count) remote package(s)")
            print("\t・\(pbxProject.localPackages.count) local package(s)")
            print("")
            try analyzeProjectTargets(pbxProject.targets)
        }
    }

    private func analyzeProjectTargets(_ targets: [PBXTarget]) throws {
        try targets.forEach { target in
            print("\t・Target \(target.name) (\(target.productType?.fileExtension ?? "")):")
            print("\t\t・\(try target.sourceFiles().count) source file(s)")
            print("\t\t・\(try target.resourcesBuildPhase()?.files?.count ?? 0) resource(s)")
            print("\t\t・\(target.packageProductDependencies.count) package dependencies")
            print("\t\t・\(target.dependencies.count) dependencies")
            print("")
        }
    }
}
