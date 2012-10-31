package pendigits.visualize;

import java.util.List;

import javax.swing.AbstractListModel;

public class ListListModel<T> extends AbstractListModel
{
	private static final long serialVersionUID = 4081589656246584825L;
	
	private final List<T> list;

	public ListListModel(List<T> list)
	{
		this.list = list;
	}

	@Override
	public int getSize()
	{
		return list.size();
	}

	@Override
	public Object getElementAt(int index)
	{
		return list.get(index);
	}

}
