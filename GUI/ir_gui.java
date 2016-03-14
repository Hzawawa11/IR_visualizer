import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.awt.event.MouseEvent;
import java.awt.event.MouseAdapter;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.GridBagLayout;
import java.awt.GridBagConstraints;
import java.awt.Dimension;
import java.awt.Insets;
import java.awt.Font;
import java.awt.BorderLayout;
import javax.swing.*;
import javax.swing.filechooser.*;
import javax.swing.event.*;
import java.util.HashMap;
import java.util.Map;


public class ir_gui extends JFrame implements ChangeListener, ActionListener{
  static ir_gui frame;
  JSlider sliderMin, sliderMax;
  static HashMap<String,JSlider> mapSlider;
  static JLabel labelMin, labelMax, labelFile;
  static int min=5, max=5; 
  static String filename = "cg.c";
  static String file_path = ""+filename;
  static JRadioButton[] radioList, radioGp;

  public static void main (String[] args) throws IOException, InterruptedException{
    frame = new ir_gui();
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setBounds(10, 10, 500, 300);
    frame.setTitle("IR_Reader in GUI ver.");
    frame.setVisible(true);
  }

  ir_gui(){ //construt
    GridBagLayout layout = new GridBagLayout();
    JPanel p = new JPanel();
    p.setLayout(layout);
    GridBagConstraints gbc = new GridBagConstraints();
    int positionY = 0;
    gbc.gridx = 0; gbc.gridy = 0;

    mapSlider = new HashMap<String,JSlider>();
    mapSlider.put("max", new JSlider(0, 30));
    mapSlider.put("min", new JSlider(0, 30));


    for(Map.Entry<String, JSlider> entry : mapSlider.entrySet()) {
      entry.getValue().setLabelTable(entry.getValue().createStandardLabels(10));
      entry.getValue().setPaintLabels(true);
      entry.getValue().setValue(5);
      entry.getValue().addChangeListener(this);
      p.add(entry.getValue());
      gbc.gridy = positionY;
      positionY++;
      layout.setConstraints(entry.getValue(), gbc);
    }
    
    positionY = 0;
    labelMin = new JLabel();
    labelMax = new JLabel();
    labelMin.setText("Min：" + mapSlider.get("min").getValue());
    labelMax.setText("Max：" + mapSlider.get("max").getValue());
    p.add(labelMin);
    p.add(labelMax);
    gbc.anchor = GridBagConstraints.CENTER;
    gbc.gridx = 1; gbc.gridy = positionY;
    layout.setConstraints(labelMin, gbc);
    positionY++;
    gbc.gridx = 1; gbc.gridy = positionY;
    layout.setConstraints(labelMax, gbc);

    positionY=2;
    ButtonGroup groupList = new ButtonGroup();
    radioList = new JRadioButton[3];
    radioList[0] = new JRadioButton("listの作成(-w)", true);
    radioList[1] = new JRadioButton("組み合わせの作成(-r)");
    radioList[2] = new JRadioButton("グループの表示(-v)");
    for(int i=0; i<3; i++){
      groupList.add(radioList[i]);
      p.add(radioList[i]);
      gbc.gridx = 0; gbc.gridy = positionY+i;
      gbc.fill = GridBagConstraints.NONE;
      gbc.anchor = GridBagConstraints.WEST;
      layout.setConstraints(radioList[i], gbc);
      layout.setConstraints(radioList[i], gbc);
      positionY++;
    }

    positionY = 2;
    ButtonGroup groupGp = new ButtonGroup();
    radioGp = new JRadioButton[3];      
    radioGp[0] = new JRadioButton("命令ごとのグループ", true);
    radioGp[1] = new JRadioButton("ベーシックブロックごとのグループ");
    radioGp[2] = new JRadioButton("関数ごとのグループ");
    for(int i=0; i<3; i++){
      groupGp.add(radioGp[i]);
      p.add(radioGp[i]);
      gbc.gridx = 1; gbc.gridy = positionY+i;
      layout.setConstraints(radioGp[i], gbc);
      layout.setConstraints(radioGp[i], gbc);
      positionY++;
    }

    JButton button_file = new JButton("file select");
    button_file.addActionListener(this);
    p.add(button_file);
    gbc.gridx = 0; gbc.gridy = 7;
    layout.setConstraints(button_file, gbc);

    labelFile = new JLabel();
    labelFile.setText("FileName：" + filename);
    p.add(labelFile);
    gbc.gridx = 1; gbc.gridy = 7;
    gbc.anchor = GridBagConstraints.CENTER;
    layout.setConstraints(labelFile, gbc);


    JButton buttonExe = new JButton("実行");
    buttonExe.addActionListener(
      new ActionListener(){
        public void actionPerformed(ActionEvent event){
          executeRuby(min, max, file_path);
        }
      }
    );

    buttonExe.setPreferredSize(new Dimension(100, 40));
    buttonExe.setFont(new Font("", Font.BOLD, 18));
    p.add(buttonExe);
    gbc.gridx = 0; gbc.gridy = 8;
    gbc.gridwidth = 2; 
    gbc.anchor = GridBagConstraints.CENTER;
    layout.setConstraints(buttonExe, gbc);
    getContentPane().add(p, BorderLayout.CENTER);
  }

  public void stateChanged(ChangeEvent e) {
    labelMin.setText("Min：" + mapSlider.get("min").getValue());
    labelMax.setText("Max：" + mapSlider.get("max").getValue());
    min = mapSlider.get("min").getValue();
    max = mapSlider.get("max").getValue();
  }

  public void actionPerformed(ActionEvent e){
    JFileChooser filechooser = new JFileChooser("/Users/hiro/Program/C/Sample/Sample11");
    FileFilter filter = new FileNameExtensionFilter("LLVM中間ファイル", "ll");
    filechooser.addChoosableFileFilter(filter);
    int selected = filechooser.showOpenDialog(this);
    if (selected == JFileChooser.APPROVE_OPTION){
      File file = filechooser.getSelectedFile();
      labelFile.setText("FileName: "+filechooser.getName(file));
      file_path = file.getAbsolutePath();
    }
  }

  public static void executeRuby(int min, int max, String file_path){
    String option1 ="", option2 = "";

    for (int i = 0 ; i < radioList.length; i++){
      if (!radioList[i].isSelected()) continue;
      switch (i){
      case 0:
        option1 = "-w";
        break;
      case 1:
        option1 = "-r";
        break;
      case 2:
        option1 = "-v";
        break;
      }
    }

    for (int i = 0 ; i < radioGp.length; i++){
      if (!radioGp[i].isSelected()) continue;
      switch (i){
      case 0:
        option2 = "-instr";
        break;
      case 1:
        option2 = "-block";
        break;
      case 2:
        option2 = "-func";
        break;
      }    
    }
    
    String command = "ruby main.rb"+" "+option1+" "+min+" "+max+" "+file_path+" "+option2+" "+"1";

    try {
      Process process = Runtime.getRuntime().exec(command, null, new File( "/Users/hiro/Program/Ruby/IR_Reader/"));
      String text;
      try (InputStream in = process.getInputStream();
        InputStreamReader isr = new InputStreamReader(in, "UTF-8");
        BufferedReader reader = new BufferedReader(isr)) {
        StringBuilder builder = new StringBuilder();
        int c;
        while ((c = reader.read()) != -1) {
          builder.append((char)c);
        }
        text = builder.toString();
      }

      int ret = process.waitFor();
      System.out.println("Command Text:");
      System.out.printf("ExecCode :%s\n", command);
      System.out.println(text);
      System.out.printf("Return = %d\n", ret);
    } catch (IOException | InterruptedException e) {
      e.printStackTrace();
    }
  }
  
}
