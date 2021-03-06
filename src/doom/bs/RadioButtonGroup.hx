package doom.bs;

import doom.html.Html.*;
import doom.core.VNode;
import doom.core.VNodes;
import doom.bs.Button.ButtonStyle;
import doom.bs.RadioButton;
using thx.Objects;
using thx.Nulls;

class RadioButtonGroup<T> extends doom.html.Component<RadioButtonGroupProps<T>> {
  public static function with<T>(change : T -> Void, values : Array<RadioButtonGroupItemState<T>>, ?options : RadioButtonGroupStateOptions)
    return new RadioButtonGroup(
      options.shallowMerge({
        change : change,
        values : values
      })
    ).asNode();

  override function render() {
    var itemOptions = {
          name : props.name,
          // block : props.block,
          disabled : props.disabled,
          outline : props.outline,
          size : props.size
        };
    return div(ButtonGroup.with({ toggle : true }, props.values.map(function(value) : VNode {
      var style = value.style;
      if(null == style)
        style = props.style;
      if(null == style)
        style = Primary;
      var itemOptions : RadioButtonOptions = itemOptions.shallowMerge({ active : value.active });
      return RadioButton.with(props.change.bind(value.value), style, itemOptions, value.label);
    })));
  }
}


typedef RadioButtonGroupItemState<T> = {
  label : VNodes,
  value : T,
  ?active : Bool,
  ?style : ButtonStyle
}

typedef RadioButtonGroupProps<T> = {> RadioButtonGroupStateOptions,
  change : T -> Void,
  values : Array<RadioButtonGroupItemState<T>>
}

typedef RadioButtonGroupStateOptions = {
  ?style : ButtonStyle,
  ?name : String,
  // ?block : Bool,
  ?disabled: Bool,
  ?outline : Bool,
  ?size: Size
}
