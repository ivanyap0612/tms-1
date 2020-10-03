package viewtrainee;

import view.UserUI;
import view.ListPanel;
import view.MenuItem;
import view.SubMenu;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JPanel;

public class TraineeUI extends UserUI {
	
	// Variables declaration
	private static final long serialVersionUID = 1L;
    private ListPanel availableTrainingList;
    private SubMenu subMenuATC;
    private ListPanel enrolledTrainingList;
    private SubMenu subMenuETC; 
 
    //Constructor
    public TraineeUI() {
    	super();
    	initTraineeComponents();
        traineeUI(); //Based on role
    }
    

	// This method is called from within the constructor to initialize the form.
    private void initTraineeComponents() {
        
        availableTrainingList = new ListPanel();
        subMenuATC = new SubMenu("Available Training Course", availableTrainingList);
        // dummy data for trainingList
        availableTrainingList.addItem(new AvailableTraining("Python Advance Training Course", "Dr Liew Kuan Yung"));
        availableTrainingList.addItem(new AvailableTraining("Software Engineering with Java", "Dr Yap Mou En"));
		availableTrainingList.addItem(new AvailableTraining("Introduction to OOPDS", "Dr Suddhish"));
        //////
		enrolledTrainingList = new ListPanel();
        // enrolledTrainingList = new EnrolledTrainingDetails("Python Advance Training Course"); //
        subMenuETC = new SubMenu("Enrolled Training Course", enrolledTrainingList);
        // dummy data for trainingList
        enrolledTrainingList.addItem(new EnrolledTraining("Python Advance Training Course"));
        enrolledTrainingList.addItem(new EnrolledTraining("Software Engineering with Java"));
		enrolledTrainingList.addItem(new EnrolledTraining("Introduction to OOPDS"));
    }
    
    
   public ListPanel getAvailableTrainingList() {
	   return availableTrainingList;
   }
   
   public ListPanel getEnrolledTrainingList() {
	   return enrolledTrainingList;
   }
   
   
   public JPanel getPanelBody() {
	   return super.getPanelBody();
   }
   
    // This method is called from within the constructor to initialize the form.
    private void traineeUI() {
    	
        //  create subMenu Training
        MenuItem menuMTC = new MenuItem(" -- Available Training Course", new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent ae) {
            	getPanelBody().removeAll();
            	getPanelBody().add(subMenuATC);
            	getPanelBody().repaint();
            	getPanelBody().revalidate();
            }
        });
        MenuItem menuTP = new MenuItem(" -- Enrolled Training Course", new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent ae) {
            	getPanelBody().removeAll();
            	getPanelBody().add(subMenuETC);
            	getPanelBody().repaint();
            	getPanelBody().revalidate();
            }
        });
        
        MenuItem menuTraining = new MenuItem("Training", null, menuMTC, menuTP);
        super.addMenu(menuTraining);
        super.home(); //show home menu initially
    }
}
