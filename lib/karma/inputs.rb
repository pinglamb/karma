require 'karma/inputs/wysiwyg_input'
require 'karma/inputs/switch_input'

::SimpleForm::FormBuilder.map_type :wysiwyg, to: Karma::Inputs::WysiwygInput
::SimpleForm::FormBuilder.map_type :switch, to: Karma::Inputs::SwitchInput
