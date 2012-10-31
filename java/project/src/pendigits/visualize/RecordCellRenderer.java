package pendigits.visualize;

import java.awt.Component;
import java.awt.Dimension;

import javax.swing.JList;
import javax.swing.ListCellRenderer;

import pendigits.PendigitRecord;


public class RecordCellRenderer extends RecordPanel implements ListCellRenderer
{

	private static final long serialVersionUID = 7803637245666808557L;

	public RecordCellRenderer(int size)
	{
		super(null);
		setPreferredSize(new Dimension(size, size));
	}

	@Override
	public Component getListCellRendererComponent(JList list, Object value,
			int index, boolean isSelected, boolean cellHasFocus)
	{
		PendigitRecord record = (PendigitRecord) value;
		setRecord(record);
		if (isSelected){
			setForeground(list.getSelectionForeground());
			setBackground(list.getSelectionBackground());
		}else{
			setBackground(list.getBackground());
			setForeground(list.getForeground());
		}
		return this;
	}

}
