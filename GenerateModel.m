function [Model] = GenerateModel(whichModelType,ModelParams)

switch(whichModelType)
    case ModelType.NoDrag
        [Model] = GenerateModel_NoDrag(ModelParams);
    case ModelType.LinearDrag
        [Model] = GenerateModel_LinearDrag(ModelParams);
    otherwise
        error("Invalid model type selected.")
end

end

