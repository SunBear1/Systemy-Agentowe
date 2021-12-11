package pl.gda.pg.eti.kask.sa.migration.behaviours;

import jade.core.Location;
import jade.core.behaviours.Behaviour;
import pl.gda.pg.eti.kask.sa.migration.agents.MigratingAgent;

/**
 *
 * @author psysiu
 */
public class MigratingBehaviour extends Behaviour {

    protected final MigratingAgent myAgent;

    public MigratingBehaviour(MigratingAgent agent) {
        super(agent);
        myAgent = agent;
    }

    @Override
    public void action() {
        int index = myAgent.getLocations().indexOf(myAgent.here()) + 1;
        index %= myAgent.getLocations().size();
        Location location = myAgent.getLocations().get(index);
        //myAgent.getLocations().remove(location);
        myAgent.doMove(location);
    }

    @Override
    public boolean done() {
        return myAgent.getLocations().isEmpty();
    }

}
