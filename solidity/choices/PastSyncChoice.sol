// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.1;
pragma experimental ABIEncoderV2;

import "./AbstractSyncChoice.sol";

contract PastSyncChoice is AbstractSyncChoice {
  constructor(Event[] memory specs) AbstractSyncChoice(specs, true) {
  }

  function evaluateEvent(uint8 index) internal override {
    if (events[index].definition == EventDefinition.CONDITIONAL) {
      uint256[] memory values = abi.decode(
        SyncOracle(events[index].oracle).query(abi.encode(activationTime)),
        (uint256[])
      );
      for (uint16 i = 0; i < values.length; i += 2) {
        if (checkExpression(events[index].expression, values[i+1])) {
          if (values[i] < activationTime) {
            evals[index] = activationTime;
          } else {
            evals[index] = values[i];
          }
          break;
        }
      }
      if (evals[index] == 0) {
        evals[index] = TOP_TIMESTAMP;
      }
      return;
    }

    super.evaluateEvent(index);
  }
}
