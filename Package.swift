// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "swift-vdf",
    products: [
        .library(
            name: "VDF",
            targets: ["VDF"]),
    ],
    targets: [
        .binaryTarget(
            name: "gmp",
            path: "Sources/gmp.xcframework"),
        .target(
            name: "chiavdf",
            dependencies: [],
            path: "Sources/chiavdf/src",
            exclude: [
                "1weso_test.cpp",
                "2weso_test.cpp",
                "avx512_test.cpp",
                "compile_asm.cpp",
                "prover_test.cpp",
                "vdf_bench.cpp",
                "vdf_client.cpp",
                "vdf_test.cpp",
                "verifier_test.cpp",
                "cmake",
                "CMakeLists.txt",
                "Makefile.vdf-client",
                "refcode/README.md",
                "uint128_t/LICENSE",
                "uint128_t/uint128_t_config.include",
                "uint128_t/uint128_t.build",
                "uint128_t/uint128_t.include",
                "uint128_t/README.md",
                "python_bindings",
                "lib/gmp-patch-6.2.1", // figure out how to apply patch
                "lib/pybind11"
            ],
            publicHeadersPath: "./",
            cxxSettings: [
                .headerSearchPath("lib/uint128_t"),
                .headerSearchPath("../../gmp"),
                .define("VDF_MODE", to: "0"),
                .define("FAST_MACHINE", to: "1"),
                .define("CHIAOSX", to: "1")
            ]),
        .target(
            name: "ObjCVDF",
            dependencies: [
                "chiavdf",
                "gmp"
            ],
            path: "Sources/ObjCVDF",
            cxxSettings: [
                .headerSearchPath("../chiavdf/src"),
                .headerSearchPath("../gmp")
            ]),
        .target(
            name: "VDF",
            dependencies: ["ObjCVDF"]),
        .testTarget(
            name: "VDFTests",
            dependencies: ["VDF"])
    ],
    cxxLanguageStandard: .cxx17
)
