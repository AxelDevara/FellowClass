// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0;

import "./interfaces/IBentoBoxMinimal.sol";
import "./utils/BoringBatchable.sol";
import "./FellowNFT.sol";
import {WAMPL} from "./WAMPL.sol";

contract FellowBentoBox is BoringBatchable {
    //amount donated by an address for leaderboard
    mapping(address => uint256) public donatedAmount;

    uint256 internal constant _vestPeriod = 5 days;

    struct Deposits {
        address user;
        address token;
        uint256 depositedShares;
    }

    IBentoBoxMinimal public immutable bentoBox;

    FellowNFT public immutable fellowNFT;

    WAMPL public immutable wrapper;

    address public owner;

    uint256 public totalDeposits;

    mapping(uint256 => Deposits) public deposits;

    constructor(FellowNFT _fellow) {
        owner = msg.sender;
        wrapper = WAMPL(address(0xD012092D13e5a4aa7A9032335B380C62Fc707232));
        bentoBox = IBentoBoxMinimal(address(0xF5BCE5077908a1b7370B9ae04AdC565EBd643966));
        fellowNFT = _fellow;
        bentoBox.registerProtocol();
    }

    function setBentoBoxApproval(
        address user,
        bool approved,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external {
        bentoBox.setMasterContractApproval(
            user,
            address(this),
            approved,
            v,
            r,
            s
        );
    }

    function approveWrapper() internal {
        IERC20(0x3E0437898a5667a4769B1Ca5A34aAB1ae7E81377).approve(address(wrapper), 100*10**19);
    }

    function mint() external{
        IERC20(0x3E0437898a5667a4769B1Ca5A34aAB1ae7E81377).transferFrom(msg.sender, address(this), 1 * 10**9);
        fellowNFT.getNewFellow(msg.sender);
    }

    function depositToFellowBentoBox(
        address token,
        uint256 amount,
        address donor,
        bool fromBentoBox
    ) external returns (uint256 depositedShares, uint currentDeposit) {
        IERC20(token).approve(address(0xF5BCE5077908a1b7370B9ae04AdC565EBd643966),amount);

        //wrap token
        approveWrapper();
        wrapper.deposit(amount);

         if (fromBentoBox) {
            depositedShares = bentoBox.toShare(address(wrapper), amount, false);
            bentoBox.transfer(
                token,
                address(this),
                address(this),
                depositedShares
            );
        } else {
            (, depositedShares) = bentoBox.deposit(
                address(wrapper),
                address(this),
                address(this),
                amount,
                0
            );
        }

        donatedAmount[donor] += amount;

        deposits[totalDeposits] = Deposits({
            user: msg.sender,
            token: address(wrapper),
            depositedShares: depositedShares
        });

        currentDeposit = totalDeposits;
        totalDeposits += 1;
    }

    function withdrawFromFellowBentoBox(
        uint256 depositId,
        uint256 amount,
        bool toBentoBox
    ) external returns (uint256 sharesWithdrawn) {
        Deposits storage deposit = deposits[depositId];
        require(msg.sender == deposit.user, "user not onwer of deposit");
        sharesWithdrawn = bentoBox.toShare(deposit.token, amount, false);
        require(
            sharesWithdrawn <= deposit.depositedShares,
            "withdraw more than available"
        );

        deposit.depositedShares -= sharesWithdrawn;

        if (toBentoBox) {
            bentoBox.transfer(
                deposit.token,
                address(this),
                deposit.user,
                sharesWithdrawn
            );
        } else {
            
            bentoBox.withdraw(
                deposit.token,
                address(this),
                deposit.user,
                0,
                sharesWithdrawn
            );
        }
    }
}
