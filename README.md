# Minimal reproducible error - hardhat network debugging disabled 

## Reproduction steps
To observe the error leave the code as it is and in a terminal run: 
```
# The error will manifest even without the ALCHEMY_KEY set
rm -rf cache/ artifacts/ && npx hardhat compile && npx hardhat node --fork https://eth-mainnet.g.alchemy.com/v2/[ALCHEMY_KEY] --verbose --trace

```

To make the error go away open OUSD.sol and delete the `rebaseOptOut` function. (Delete everything from the `START DELETE THIS OUT` comment up until the `// END OF DELETE THIS OUT` comment)

## Error
The error seems to happen because the compiled contract contains an opCode that is not recognized by the EDR (Ethereum Development Runtime). Example of the error: 
```
  hardhat:core:vars:varsManager Creating a new instance of VarsManager +0ms
  hardhat:core:vars:varsManager Loading ENV variables if any +0ms
  hardhat:core:config Loading Hardhat config from /Users/domen-privat/projects/OriginProtocol/hardhat-tracer-mre/hardhat.config.js +0ms
  hardhat-tracer:extend:config extending config... +0ms
  hardhat-tracer:extend:config config extended! +0ms
  hardhat:core:hre Creating HardhatRuntimeEnvironment +0ms
  hardhat-tracer:extend:hre extending environment... +0ms
  hardhat-tracer:decoder Decoder constructor +0ms
  hardhat-tracer:decoder _updateArtifacts called +0ms
  hardhat-tracer:extend:hre getting hardhat base provider +0ms
  hardhat:core:hre Creating provider for network hardhat +1ms
  hardhat-tracer:extend:hre environment extended! +0ms
  hardhat:core:hardhat-network:provider Making tracing config +0ms
  hardhat:core:global-dir Looking up Client Id at /Users/domen-privat/Library/Application Support/hardhat-nodejs/analytics.json +0ms
  hardhat:core:hardhat-network:provider Creating EDR provider +2ms
  hardhat:core:global-dir Client Id found: dda52fff-ac42-430f-a843-7a3849a7e3ba +3ms
  hardhat:core:hre Running task node +243ms
  hardhat:core:hre Running node's super +1ms
  hardhat:core:hre Running task node:get-provider +0ms
  hardhat:core:hre Running node:get-provider's super +0ms
thread '<unnamed>' panicked at crates/edr_solidity/src/source_map.rs:162:48:
Invalid opcode
note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
The Hardhat Network tracing engine could not be initialized. Run Hardhat with --verbose to learn more.
  hardhat:core:hardhat-network:node Hardhat Network tracing disabled: VmTraceDecoder failed to be initialized. Please report this to help us improve Hardhat.
  hardhat:core:hardhat-network:node  Error: Invalid opcode
    at initializeVmTraceDecoderWrapper (/Users/domen-privat/projects/OriginProtocol/hardhat-tracer-mre/node_modules/hardhat/src/internal/hardhat-network/stack-traces/vm-trace-decoder.ts:19:5)
    at new EdrProviderWrapper (/Users/domen-privat/projects/OriginProtocol/hardhat-tracer-mre/node_modules/hardhat/src/internal/hardhat-network/provider/provider.ts:188:31)
    at Function.create (/Users/domen-privat/projects/OriginProtocol/hardhat-tracer-mre/node_modules/hardhat/src/internal/hardhat-network/provider/provider.ts:327:21)
    at createHardhatNetworkProvider (/Users/domen-privat/projects/OriginProtocol/hardhat-tracer-mre/node_modules/hardhat/src/internal/hardhat-network/provider/provider.ts:634:20)
    at createProvider (/Users/domen-privat/projects/OriginProtocol/hardhat-tracer-mre/node_modules/hardhat/src/internal/core/providers/construction.ts:85:23) {
  code: 'GenericFailure'
} +0ms
  hardhat:core:hardhat-network:provider EDR provider created +19ms
  hardhat-tracer:extend:hre tracer.switch created +289ms
  hardhat-tracer:extend:hre trace recorder added +0ms
  hardhat-tracer:decoder _updateArtifacts finished +292ms

```

## Opcodes 
Here [is the diff](https://www.diffchecker.com/k5B0uByT/) between a decompiled contract that contains no problematic opcodes (left part of diff) and the one with problematic opcodes (right part of diff)

The codes I see in the problematic contract that I do not see in the non problematic one are: 
- ADDMOD
- SMOD
- CALLER

Though without debugging the Rust module `edr_solidity/src/source_map.rs` this is just guessing.