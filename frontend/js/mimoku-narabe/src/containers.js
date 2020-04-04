import { connect } from "react-redux";
import { clickSquare, jumpToPast } from "./actions";
import { Game } from "./components";

 const mapStateToProps = (state, ownProps) => {
  return state.game;
};

 const mapDispatchToProps = (dispatch, ownProps) => {
  return {
    handleClick: index => {
      dispatch(clickSquare(index));
    },
    jumpTo: () => {}
  };
};

 export const GameContainer = connect(
  mapStateToProps,
  mapDispatchToProps
)(Game);
