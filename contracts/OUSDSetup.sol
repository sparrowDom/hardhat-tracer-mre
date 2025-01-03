// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./OUSD.sol";

/**
 * @title Mixin for setup and deployment
 * @author Rappie
 */
contract OUSDSetup {
    OUSD ousd = new OUSD();
}
