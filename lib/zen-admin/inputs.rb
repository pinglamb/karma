require 'zen-admin/inputs/wysiwyg_input'
require 'zen-admin/inputs/switch_input'

::SimpleForm::FormBuilder.map_type :wysiwyg, to: ZenAdmin::Inputs::WysiwygInput
::SimpleForm::FormBuilder.map_type :switch, to: ZenAdmin::Inputs::SwitchInput
