// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.7.1;
pragma experimental ABIEncoderV2;

/*
 * General base interface with structures and enumerations which all contracts
 * regularly need access to.
 */
abstract contract Base {
  struct Expression {
    Operator operator;
    uint256 value;
  }

  uint256 constant TOP_TIMESTAMP = type(uint256).max;

  enum Operator {
    GREATER,
    GREATER_EQUAL,
    EQUAL,
    LESS_EQUAL,
    LESS
  }
}

abstract contract Choice {
  /*
   * Initially activate the deferred choice instance.
   * @param targetEvent Index of the event to trigger if evaluated successfully; 
   *                    otherwise, an arbitrary implicit event might be chosen if
   *                    it can trigger "immediately" (potentially after waiting
   *                    for callbacks)
   */
  function activate(uint8 targetEvent) public virtual;

  /*
   * Try to trigger the event with the given index.
   * @param targetEvent Index of the event to trigger if evaluated successfully; 
   *                    otherwise, an arbitrary implicit event might be chosen if
   *                    it can trigger "immediately" (potentially after waiting
   *                    for callbacks)
   */
  function trigger(uint8 targetEvent) public virtual;
}

abstract contract SyncOracle is Base {
  function set(bytes memory newValue)
      external virtual;
  function query(bytes memory parameters)
      public view virtual returns (bytes memory result);
}

abstract contract AsyncOracle is Base {
  event Query(
    address sender, uint16 correlation, bytes parameters
  );
  function query(
    uint16 correlation, bytes memory parameters
  ) public {
    emit Query(msg.sender, correlation, parameters);
  }
}

abstract contract OracleConsumer {
  function oracleCallback(uint16 correlation, bytes calldata result) public virtual;
}

/*
 * Helper function that returns true if the given expression is satisfied by the value.
 */
function checkExpression(Base.Expression memory c, uint256 value) pure returns (bool result) {
  if (c.operator == Base.Operator.GREATER) {
    result = value > c.value;
  } else if (c.operator == Base.Operator.GREATER_EQUAL) {
    result = value >= c.value;
  } else if (c.operator == Base.Operator.EQUAL) {
    result = value == c.value;
  } else if (c.operator == Base.Operator.LESS_EQUAL) {
    result = value <= c.value;
  } else if (c.operator == Base.Operator.LESS) {
    result = value < c.value;
  }
}
