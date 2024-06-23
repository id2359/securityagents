package cameras;

import cartago.*;

public class Camera extends Artifact {
    private String id;
    void init(String myId) {
        id = myId;
        defineObsProperty("id", id);
    }

    @OPERATION
    void get_picture() {
        ObsProperty prop = getObsProperty("count");
        prop.updateValue(prop.intValue()+1);
        signal("tick");
    }

    @OPERATION
    void inc_get(int inc, OpFeedbackParam<Integer> newValueArg) {
        ObsProperty prop = getObsProperty("count");
        int newValue = prop.intValue()+inc;
        prop.updateValue(newValue);
        newValueArg.set(newValue);
    }
    
}
