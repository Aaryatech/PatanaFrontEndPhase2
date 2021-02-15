package com.monginis.ops.model.grngvn;

public class CreditNoteGrnGvnItemWise {

	
	private String uid;
	private String grngvnSrno;
	private String grngvnDate;
	private String itemName;
	private int reqQty;
	private int aprvQty;
	private int grngvnStatus;
	private int grnGvnHeaderId;
	private int isGrn;
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getGrngvnSrno() {
		return grngvnSrno;
	}
	public void setGrngvnSrno(String grngvnSrno) {
		this.grngvnSrno = grngvnSrno;
	}
	public String getGrngvnDate() {
		return grngvnDate;
	}
	public void setGrngvnDate(String grngvnDate) {
		this.grngvnDate = grngvnDate;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public int getGrngvnStatus() {
		return grngvnStatus;
	}
	public void setGrngvnStatus(int grngvnStatus) {
		this.grngvnStatus = grngvnStatus;
	}
	public int getGrnGvnHeaderId() {
		return grnGvnHeaderId;
	}
	public void setGrnGvnHeaderId(int grnGvnHeaderId) {
		this.grnGvnHeaderId = grnGvnHeaderId;
	}
	public int getIsGrn() {
		return isGrn;
	}
	public void setIsGrn(int isGrn) {
		this.isGrn = isGrn;
	}
	public int getReqQty() {
		return reqQty;
	}
	public void setReqQty(int reqQty) {
		this.reqQty = reqQty;
	}
	public int getAprvQty() {
		return aprvQty;
	}
	public void setAprvQty(int aprvQty) {
		this.aprvQty = aprvQty;
	}
	@Override
	public String toString() {
		return "CreditNoteGrnGvnItemWise [uid=" + uid + ", grngvnSrno=" + grngvnSrno + ", grngvnDate=" + grngvnDate
				+ ", itemName=" + itemName + ", reqQty=" + reqQty + ", aprvQty=" + aprvQty + ", grngvnStatus="
				+ grngvnStatus + ", grnGvnHeaderId=" + grnGvnHeaderId + ", isGrn=" + isGrn + "]";
	}
	
}
