function projectName = InputProjectData()

    prompt = {'Enter Project Name:'};
    dlgTitle = 'Input';
    numLines = 1;
    defaultValues = {'New Project'};
    inputData = inputdlg(prompt,dlgTitle,numLines,defaultValues);

    projectName = inputData{1};

end