package com.lyq.struts.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.servlet.ServletUtilities;

import com.lyq.dao.CategoryDao;
import com.lyq.persistence.Category;
import com.lyq.struts.form.CategoryForm;
import com.lyq.util.ChartUtil;
/**
 * ?????Action??
 * @author Li Yong Qiang
 */
public class CategoryAction extends BaseAction {

	//??????????
	public ActionForward add(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		//?????????
		CategoryForm cf = (CategoryForm)form;
		//????Category????
		Category c = new Category();
		c.setName(cf.getName());
		c.setDescription(cf.getDescription());
		c.setCreateTime(new Date());
		if(cf.getId() != 0){
			c.setId(cf.getId());
		}
		CategoryDao dao = new CategoryDao();
		dao.saveOrUpdate(c);
		return mapping.findForward("paging");
	}
	
	//??????
	public ActionForward findAll(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		List list = null;
		CategoryDao dao = new CategoryDao();
		list = dao.findByHQL("from Category");
		request.setAttribute("list", list);
		return mapping.findForward("findAllSuccess");
	}
	
	//?????
	public ActionForward edit(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		CategoryForm cf = (CategoryForm)form;
		// ???id??????
		if(cf.getId() > 0){
			CategoryDao dao = new CategoryDao();
			Category c = dao.loadCategory(cf.getId());
			BeanUtils.copyProperties(cf, c);
		}
		return mapping.findForward("edit");
	}
	//??????
	public ActionForward delete(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		CategoryForm cf = (CategoryForm)form;
		// ???id??????
		if(cf.getId() > 0){
			CategoryDao dao = new CategoryDao();
			Category c = dao.loadCategory(cf.getId());
			dao.delete(c);	//??????
		}
		return mapping.findForward("paging");
	}
	
	//???
	public ActionForward paging(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		//?????????
		String currPage = request.getParameter("currPage");
		String action = request.getContextPath()+"/baseData/category.do?command=paging";
		String hql = "from Category";
		//??????
		Map map = this.getPage(hql, recPerPage, currPage, action,null);
		//??????????request??
		request.setAttribute("list", map.get("list"));
		//?????????????????
		request.setAttribute("pagingBar", map.get("bar"));
		return mapping.findForward("findAllSuccess");
	}
	
	// ????????????
	public ActionForward findCategoryAndCound(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		// ?????CategoryDao????
		CategoryDao dao = new CategoryDao();
		// ????????????
		List list = dao.findCategoryAndCount();
		ChartUtil chartUtil = new ChartUtil();
		// ????JFreeChart???
		JFreeChart chart = chartUtil.categoryChart(list);
		if(chart != null){
			// ??????????
			String fileName = ServletUtilities.saveChartAsJPEG(chart,500,300,request.getSession());
	    	// ????????
			String graphURL = request.getContextPath() + "/DisplayChart?filename=" + fileName;
	    	// ????????????request??
			request.setAttribute("graphURL", graphURL);
		}
		// ??????
		return mapping.findForward("categoryGraph");
	}
}
