// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title OUSD Token Contract
 * @dev ERC20 compatible contract for OUSD
 * @dev Implements an elastic supply
 * @author Origin Protocol Inc
 */

contract OUSD {
    // keccak256("OUSD.reentry.status");
    bytes32 private constant reentryStatusPosition =
        0x53bf423e48ed90e97d02ab0ebab13b2a235a6bfbe9c321847d5c175333ac4535;
    uint256 constant _NOT_ENTERED = 1;
    uint256 constant _ENTERED = 2;
    modifier nonReentrant() {
        bytes32 position = reentryStatusPosition;
        uint256 _reentry_status;
        // solhint-disable-next-line no-inline-assembly
        assembly {
            _reentry_status := sload(position)
        }

        // On the first call to nonReentrant, _notEntered will be true
        require(_reentry_status != _ENTERED, "Reentrant call");
        // if (_reentry_status != _ENTERED) {
        //     revert("Reentrant call");
        // }

        // Any calls to nonReentrant after this point will fail
        // solhint-disable-next-line no-inline-assembly
        assembly {
            sstore(position, _ENTERED)
        }

        _;

        // By storing the original value once again, a refund is triggered (see
        // https://eips.ethereum.org/EIPS/eip-2200)
        // solhint-disable-next-line no-inline-assembly
        assembly {
            sstore(position, _NOT_ENTERED)
        }
    }
    function mint(address _account, uint256 _amount) external {
        _mint(_account, _amount);
    }
    function _mint(address _account, uint256 _amount) internal nonReentrant {
        require(_account != address(0), "Mint to the zero address");
    }
    function burn(address account, uint256 amount) external {
        _burn(account, amount);
    }
    function _burn(address _account, uint256 _amount) internal nonReentrant {
    }


    // START DELETE THIS OUT - to make the `Hardhat Network tracing disabled: VmTraceDecoder failed to be initialized.`
    // error go away. 
    /**
     * @dev Explicitly mark that an address is non-rebasing.
     */
    function rebaseOptOut() public nonReentrant {
        // Set fixed credits per token
    }

    // END OF DELETE THIS OUT
}
