{
    package Lamborghini::Forms::UserRoleForm;
    use HTML::FormHandler::Moose;
    extends 'HTML::FormHandler::Model::DBIC';
    with 'HTML::FormHandler::Render::Simple';


    has '+item_class' => ( default => 'UserRole' );

    has_field 'user' => ( type => 'Select', );
    has_field 'role' => ( type => 'Select', );
    has_field 'submit' => ( widget => 'submit' )
}


