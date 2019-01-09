
# Data that drives the create step picker registration for this plugin.
my %runTestNG = (
    label       => "TestNG - Run TestNG",
    procedure   => "runTestNG",
    description => "Integrates TestNG Test Tool into Electric Commander",
    category    => "Test"
);

$batch->deleteProperty("/server/ec_customEditors/pickerStep/TestNG - Run TestNG");
$batch->deleteProperty("/server/ec_customEditors/pickerStep/TestNG");

@::createStepPickerSteps = (\%runTestNG);
